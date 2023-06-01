function sum(a, b){
    return a+b;
}

// arrow syntax
const sum2 = (a,b) => {
    return a+b;
}

const sum3 = (a,b) => a+b;

function isPos(x){
    return x>=0;
}

const isPos2 = x => x>=0;

/* Difference of this between normal func and arrow func
* arrow func: this = defiend location 
    this inside an arrow function always refers to this from the outer context.
* normal func: this = called location 
    redefine the value of this within the function.
*/
console.log(this,this.name);
let newObject = {
    name : "supi",
    arrowFunc: () => {
        console.log(`Arrow: ${this.name}`); 
    },
    regularFunc() {
        console.log(`Function: ${this.name}`); 
    }   
}
newObject.arrowFunc(); // Suprabha
newObject.regularFunc(); // supi

  class Person {
    constructor(name) {
      this.name = name
    }
  
    printNameArrow() {
      setTimeout(() => {
        console.log(`Arrow: ${this.name}`)
      }, 100)
    }
  
    printNameFunction() {
      setTimeout(function() {
        console.log(`Function: ${this.name}`)
      }, 100)
    }
  }
  
  const person = new Person('Kyle')
  person.printNameArrow()
  // Arrow: Kyle
  person.printNameFunction()
  // Function: 



