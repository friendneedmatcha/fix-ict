import 'dotenv/config';
import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaClient } from '../generated/prisma/client';
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
      role: 'ADMIN',
    },
    {
      firstName: 'User1',
      lastName: 'FixICT',
      email: 'user1@fixict.com',
      role: 'USER',
    },
    {
      firstName: 'User2',
      lastName: 'FixICT',
      email: 'user2@fixict.com',
      role: 'USER',
    },
  ];

  for (const user of users) {
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
