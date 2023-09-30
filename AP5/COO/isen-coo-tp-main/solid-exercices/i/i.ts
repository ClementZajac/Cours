interface Shape {
  getArea(): number;
}

interface Volume extends Shape {
  getVolume(): number;
}

class Cylinder implements Volume {
  height = 0;

  radius = 0;

  getVolume(): number {
    return Math.PI * Math.pow(this.radius, 2) * this.height;
  }

  getArea(): number {
    return 2 * Math.PI * this.radius * (this.height + this.radius);
  }
}

class Square implements Shape {
  side = 0;

  getArea(): number {
    return Math.pow(this.side, 2);
  }
}
