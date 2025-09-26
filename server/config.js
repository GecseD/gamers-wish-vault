import dotenv from "dotenv";

dotenv.config({ path: "../.env" })

export const MONGO_DB_CLUSTER_PASSWORD = process.env.MONGO_DB_CLUSTER_PASSWORD;
export const MONGO_DB_USERNAME = process.env.MONGO_DB_USERNAME;
export const API_KEY = process.env.API_KEY;
