type JSON = Record<string, any>;

async function handleResponse<T>(response: Response): Promise<T> {
  if (!response.ok) {
    const errorBody = await response.text().catch(() => '无法获取错误详情');
    throw new Error(`网络响应不成功: ${ response.status } ${ response.statusText }。详细信息: ${ errorBody }`);
  }
  return await response.json() as Promise<T>;
}

async function GET<T = JSON>(url: string): Promise<T> {
  try {
    const response = await fetch(url, { method: 'GET' });
    return handleResponse<T>(response);
  } catch (error) {
    console.error('GET 请求操作中出现问题:', error);
    throw error;
  }
}

async function POST<T = JSON>(url: string, data: JSON): Promise<T> {
  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data)
    });
    return handleResponse<T>(response);
  } catch (error) {
    console.error('POST 请求操作中出现问题:', error);
    throw error;
  }
}

export { GET, POST };


