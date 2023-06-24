// script.js

const countElement = document.querySelector(".viewer-count");

async function updateViewerCount() {
  try {
    let response = await fetch("https://8d1pc0u0i7.execute-api.eu-central-1.amazonaws.com/prod");
    if (response.ok) {
      let data = await response.json();
      const viewerCount = parseFloat(data);
      displayViewerCount(viewerCount);
       } else {
      console.error('Error: Failed to fetch viewer count');
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

function displayViewerCount(count) {
  const countElement = document.getElementById("count");
  countElement.textContent = count;
}

updateViewerCount();



