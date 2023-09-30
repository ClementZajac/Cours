abstract class Employee {

  public name: string;
  public firstname: string;

  constructor(name: string, firstname: string) {
    this.name = name;
    this.firstname = firstname;
  }
}

class Customer {
  public fullname: string;

  constructor(fullname: string) {
    this.fullname = fullname;
  }
}

interface AccountDisplayerService {
  public displayWelcomeMessage(entity: Employee | Customer) {
    if (entity instanceof Employee) {
      console.log(`Welcome ${entity.firstname} ${entity.name} !`);
    } else if (entity instanceof Customer) {
      console.log(`Welcome ${entity.fullname} !`);
    }
  }
}



