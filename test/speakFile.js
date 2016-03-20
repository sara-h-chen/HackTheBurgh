var speechSynthesiser = window.speechSynthesis;
var voices = speechSynthesiser.getVoices();

function main() {
    document.getElementById('files').addEventListener('change', handleFileSelect, false);

}

function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    for (var i = 0, f; f = files[i]; i++) {

        var reader = new FileReader();
        var text;
        reader.onload = function(e) {
            text = e.target.result;
            console.log(text);
            var utterance = new SpeechSynthesisUtterance(text);
            utterance.pitch = 1;
            utterance.rate = 1;
            utterance.voice = voices[0];
            speechSynthesiser.speak(utterance);
        }
        reader.readAsText(f)


    }


}
