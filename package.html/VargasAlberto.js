let escapedQuotes = "He said, \"Hello, how are you?\"";
console.log("Escaped Quotes: ", escapedQuotes);


function countWords(str) {
    return str.split(/\s+/).filter(Boolean).length;
}
let text = "hello everyone.";
console.log("Word Count: ", countWords(text));

let untrimmedString = "   Hello, World!   ";
let trimmedString = untrimmedString.trim();
console.log("Trimmed String: '", trimmedString, "'");

let sentence = "Apple, Banana, Cherry";
let fruitArray = sentence.split(", ");
console.log("Split String into Array: ", fruitArray);

let sentenceToCheck = "This is a test sentence.";
let containsTest = sentenceToCheck.includes("test");
console.log("Contains 'test': ", containsTest);

let strToSlice = "Hello there";
let slicedStr = strToSlice.slice(0, 10);
console.log("Sliced String: ", slicedStr);

let originalStr = "I like apples. Apples are great.";
let modifiedStr = originalStr.replace(/Apples/g, "Oranges");
console.log("Replaced String: ", modifiedStr);