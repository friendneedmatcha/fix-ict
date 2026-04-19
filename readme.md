# GreenWeather

![Flutter](https://img.shields.io/badge/Flutter-Frontend-blue?logo=flutter)
![Nestjs](https://img.shields.io/badge/nest.js-Backend-red?logo=nestjs)
![Nodejs](https://img.shields.io/badge/Node.js-Runtime-green?logo=node.js)
![MySQL](https://img.shields.io/badge/MySQL-Database-blue?logo=mysql)

## 🌱 Description

FixICT เป็นระบบแจ้งซ่อมสิ่งของภายในคณะ

## 🚀 Features

ระบบช่วยให้ผู้ใช้สามารถแจ้งซ่อมอุปกรณ์ภายในคณะได้อย่างสะดวก โดยสามารถ

- ถ่ายภาพสิ่งของที่ชำรุด
- ใช้ Gemini AI วิเคราะห์หมวดหมู่ปัญหา
- ติดตามสถานะการซ่อม
- ให้คะแนนและ feedback หลังซ่อม

ช่วยลดขั้นตอนการแจ้งซ่อมแบบเดิม และเพิ่มความรวดเร็วในการจัดการงานซ่อม

## 🧑‍💻 Tech Stack

| Layer    | Technology        |
| -------- | ----------------- |
| Frontend | Flutter           |
| Backend  | Node.js + Nest.js |
| Database | MySQL             |
| API      | Gemini API        |

## ⚙️ Prerequisites

Before starting the setup, please make sure you have the following installed on your machine

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Nest CLI](https://docs.nestjs.com/cli/overview)

## 📦 Setup and Installation - Frontend

Follow these steps to set up the Flutter frontend locally

1. **Clone the repository**

   ```bash
   git clone https://github.com/friendneedmatcha/fix-ict
   cd fix-ict
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Create a `.env` file**

   Inside the root folder of the project (e.g., `frontend/`), create a new `.env` file and add

   ```env
    API_URL="http://localhost:3000"
    GEMINI_API_KEY="your key"
   ```

4. **Run the application** on your emulator or device.

   ```env
    fluter run
   ```

## Setup and Installation - Backend

1. **Navigate to the server folder**

   ```bash
   cd backend
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Create a `.env` file**

   Inside `backend/`, create a `.env` file and add the following configuration:

   ```env
    DATABASE_URL="mysql://username:password@yourhost:3306/yourDB"
    DATABASE_USER="username"
    DATABASE_PASSWORD="password"
    DATABASE_NAME="yourdb"
    DATABASE_HOST="yourhost"
    DATABASE_PORT=3306
    JWT_SECRET="secret"
    JWT_REFRESH="secret"
   ```

4. **Migrate database**

   After setting `DATABASE_URL` in .env file you can migrate database into your db server.

   ```bash
   npx prisma migrate dev
   npx prisma db seed
   npx prisma generate
   ```

5. **Start the backend server**

   ```bash
   npm run start:dev
   ```

6. **IMPORTANT**

   ผู้ใช้แอดมิน 1 คน - มีอีเมล admin@fixict.com และรหัสผ่าน Fixict555

   ผู้ใช้ 2 คน
   - มีอีเมล user1@fixict.com และรหัสผ่าน Fixict555
   - มีอีเมล user2@fixict.com และรหัสผ่าน Fixict555
