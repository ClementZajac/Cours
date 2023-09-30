import axios from "axios";

abstract class client {
  abstract get(url: string): Promise<any>;
  abstract post(url: string, payload: any): Promise<any>;
}

class HttpClient extends client {
  async get(url: string) {
    return await axios.get(url);
  }

  async post(url: string, payload: any) {
    return await axios.post(url, payload);
  }
}

const conn = new HttpClient();

class ProductService {
  async getProducts() {
    return await conn.get("/products");
  }

  async createProduct(product: any) {
    return await conn.post("/products", product);
  }
}
