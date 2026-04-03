// upload/multer.config.ts
import { diskStorage } from 'multer';
import { extname } from 'path';
import { Request } from 'express';

export const multerConfig = {
  storage: diskStorage({
    destination: './uploads', // โฟลเดอร์เก็บไฟล์
    filename: (
      req: Request,
      file: Express.Multer.File,
      callback: (error: Error | null, filename: string) => void,
    ) => {
      const uniqueName = Date.now() + '-' + Math.round(Math.random() * 1e9);
      callback(null, uniqueName + extname(file.originalname));
    },
  }),

  fileFilter: (
    req: Request,
    file: Express.Multer.File,
    callback: (error: Error | null, acceptFile: boolean) => void,
  ) => {
    if (!file.mimetype.match(/\/(jpg|jpeg|png|gif)$/)) {
      return callback(new Error('Only image files are allowed!'), false);
    }
    callback(null, true);
  },

  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB
  },
};
