import { createError, defineEventHandler } from 'h3';
import fs from 'fs/promises';
import path from 'path';

export default defineEventHandler(async (event) => {
  try {
    const configPath = path.resolve(process.cwd(), 'public', 'config.json');

    const jsonData = await fs.readFile(configPath, 'utf8');
    return JSON.parse(jsonData)
  } catch (error: any) {
    console.error('配置文件读取或解析失败:', error);

    let errorMessage = "配置文件处理时发生未知错误。";
    if (error.code === 'ENOENT') {
      errorMessage = "配置文件未找到，请检查文件路径是否正确。";
    } else if (error.name === 'SyntaxError') {
      errorMessage = "配置文件格式错误，请确保 JSON 格式有效。";
    }

    throw createError({
      statusCode: 500,
      statusMessage: "请求错误",
      data: { message: errorMessage }
    });
  }
});
