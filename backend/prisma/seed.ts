import 'dotenv/config';
import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaClient, Role, Status } from '../generated/prisma/client';
import * as bcrypt from 'bcrypt';

const adapter = new PrismaMariaDb({
  host: process.env.DATABASE_HOST,
  user: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE_NAME,
  connectionLimit: 5,
});
const prisma = new PrismaClient({ adapter });
async function main() {
  const hashpassword = await bcrypt.hash('Fixict555', 10);
  const users = [
    {
      firstName: 'Admin',
      lastName: 'FixICT',
      email: 'admin@fixict.com',
      role: Role.ADMIN,
    },
    {
      firstName: 'User1',
      lastName: 'FixICT',
      email: 'user1@fixict.com',
      role: Role.USER,
    },
    {
      firstName: 'User2',
      lastName: 'FixICT',
      email: 'user2@fixict.com',
      role: Role.USER,
    },
  ];

  for (const user of users) {
    console.log('seed add user', user.firstName, 'success');
    await prisma.user.upsert({
      where: { email: user.email },
      update: {},
      create: {
        ...user,
        password: hashpassword,
        tel: '0000000000',
      },
    });
  }
  await prisma.category.createMany({
    data: [
      { name: 'ไอที' },
      { name: 'ไฟฟ้า' },
      { name: 'อินเทอร์เน็ต' },
      { name: 'สถานที่' },
      { name: 'เครื่องใช้' },
      { name: 'อื่นๆ' },
    ],
    skipDuplicates: true,
  });
  console.log('seed add category success');

  const report1 = await prisma.report.create({
    data: {
      title: 'พัดลมพัง',
      location: '313',
      priority: 'MEDIUM',
      description: 'พัดลมเปิดไม่ติด',
      userId: 2,
      categoryId: 2,
      imageBefore: 'demo1.jpg',
    },
  });
  console.log('seed add report 1 success');

  const report2 = await prisma.report.create({
    data: {
      title: 'เก้าอี้พัง',
      location: '211',
      priority: 'LOW',
      description: 'เก้าอี้ขาหัก',
      userId: 3,
      categoryId: 5,
      imageBefore: 'demo2.jpg',
    },
  });
  console.log('seed add report 2 success');

  await prisma.reportUpdate.create({
    data: {
      reportId: report1.id,
      status: Status.SUCCESS,
      imageAfter: 'demo3.jpg',
      updatedBy: 1,
    },
  });
  console.log('seed update status report 1 success');

  await prisma.reportUpdate.create({
    data: {
      reportId: report2.id,
      status: Status.IN_PROGRESS,
      // imageAfter: 'demo4.jpg',
      updatedBy: 1,
    },
  });
  console.log('seed update status report 2 success');
  await prisma.report.update({
    where: {
      id: report1.id,
    },
    data: {
      status: Status.SUCCESS,
    },
  });

  await prisma.feedback.create({
    data: {
      reportId: report1.id,
      userId: 2,
      rating: 4,
      comment: 'ดีมากเลยคับ',
    },
  });
  console.log('seed feedback  report 1 success');

  console.log('Seed completed');

  // console.log({ , user1, user2 });
}
main()
  .then(async () => {
    await prisma.$disconnect();
    // await (await pool).end();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    // await (await pool).end();
    process.exit(1);
  });
