"use strict"
function changeImage(filename, theText) {
  let image = document.getElementById('theImage');
  let text = document.getElementById('theText');
  text.textContent = theText;
  image.src = filename;
}
