let dog = { dogName: "Olivia",
    weight: 2.4,
    color: "White"
    breed: "Shi tzu"

};

class ClassName {
    constructor(prop1, prop2){
        this.prop1 = prop1;
        this.prop2 = prop2;
    }
}

let obj = new ClassName("arg1", "arg2")

function Dog(dogName, weight, color, breed) {
    this.dogName = dogName;
    this.weight = weight;
    this.color = color;
    this.breed = breed;
}
let dog = new dog("Pedri", 17, "Black and white", "Golden")
class dog {
    constructor(dogName, weight, color, breed) {
        this.dogName = dogName;
        this.weight = weight;
    }
}
let dog = new Dog("Olivia", 2.4, "white", "shi tzu")