import { expect } from "chai";

class Rectangle {
  constructor(
    private width: number,
    private length: number,
  ) {
    this.setWidth(width);
    this.setLength(length);
  }

  public setWidth(width: number) {
    this.width = width;
  }

  public setLength(length: number) {
    this.length = length;
  }

  public getArea() {
    return this.width * this.length;
  }
}

class Square extends Rectangle {
  constructor(side: number) {
    super(side, side);
  }
}

const rect: Rectangle = new Square(10);
rect.setWidth(20);

expect(rect.getArea()).to.equal(400); // MAIS CA VA RETOURNER 200 !
