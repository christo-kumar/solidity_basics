console.log("$ node AsyncJS.js ");
console.log("******** Welcome to Async JS **********");

const promise = new Promise((resolve, reject) => {
  setTimeout(() => resolve(100), 1000);
});

async function demoAsync() {
  //Use this when we want the asynchronous execution..
  promise
    .then((val) => {
      console.log(val);
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {
      console.log("Coming from finally");
    });

  //use this if resolution is required for program to proceed..
  const result = await promise;
  console.log(result);
}

demoAsync();
