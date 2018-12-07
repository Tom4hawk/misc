var imagesLoaded = 0;
window.addEventListener("load", function() {
	var generateButton = document.getElementById("generate-button");
	generateButton.onclick = generateNewAnimal;
});


function generateNewAnimal() {
	var arrayTopSize = animalData.top.length - 1;
	var arrayBottomSize = animalData.bottom.length - 1;
	var upperBody = getRandomInt(0, arrayTopSize);
	var lowerBody = getRandomInt(0, arrayBottomSize);

	document.getElementById("animal-name").innerHTML = animalData.top[upperBody].name + animalData.bottom[lowerBody].name;

	drawNewAnimal(upperBody, lowerBody);
}

var img1;
var img2;

function drawNewAnimal(upper, lower) {
	img1 = new Image();
	img2 = new Image();

	img1.onload = function() {drawBufferedPictures(upper, lower)};
	img2.onload = function() {drawBufferedPictures(upper, lower)};

	img1.src = "pictures/" + animalData.top[upper].file;
	img2.src = "pictures/" + animalData.bottom[lower].file;
}

function drawBufferedPictures(upper, lower){
	imagesLoaded += 1;

    if(imagesLoaded == 2) {
		var canvas = document.getElementById("canvas");
		var ctx = canvas.getContext("2d");
		var viewportHeight = document.documentElement.clientHeight
		var scaleFactor = -1.0;

		ctx.clearRect(0, 0, canvas.width, canvas.height);

		canvas.height = img1.height + img2.height;
		if( (canvas.height + 200) > viewportHeight ){
			scaleFactor =  (0.8 * viewportHeight) / (canvas.height + 100);
			scaleFactor =  scaleFactor.toFixed(2);
		}

		if(animalData.top[upper].start > animalData.bottom[lower].start){
			var dif = animalData.top[upper].start - animalData.bottom[lower].start

			if((img2.width + dif) > img1.width){
				canvas.width = (img2.width + dif);
			} else{
				canvas.width = img1.width;
			}

			if(scaleFactor !== -1.0){
				canvas.width = canvas.width * scaleFactor;
				canvas.height = canvas.height * scaleFactor;
				ctx.scale(scaleFactor,scaleFactor);
			}

			ctx.drawImage(img1, 0, 0);
			ctx.drawImage(img2, dif, img1.height);
		} else{
			var dif = animalData.bottom[lower].start -animalData.top[upper].start;

			if((img1.width + dif) > img2.width){
				canvas.width = (img1.width + dif);
			} else{
				canvas.width = img2.width;
			}

			if(scaleFactor !== -1.0){
				canvas.width = canvas.width * scaleFactor;
				canvas.height = canvas.height * scaleFactor;
				ctx.scale(scaleFactor,scaleFactor);
			}

			ctx.drawImage(img1, dif, 0);
			ctx.drawImage(img2, 0, img1.height);
		}

		imagesLoaded = 0;
    }
}

function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}
