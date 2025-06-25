import 'reflect-metadata';
import { DataSource } from 'typeorm';


export const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'postgres',
  password: 'postgres',
  database: 'myapp',
  synchronize: true, // ⚠️ use false em produção
  logging: true,
  migrations: [],
  subscribers: [],
});