// Adapted from http://stackoverflow.com/questions/1895727/how-can-i-detect-the-browser-with-php-or-javascript?rq=1
// and http://docs.mathjax.org/en/latest/dynamic.html

// Call MathJax for all browser.
(function () {
  var head = document.getElementsByTagName("head")[0],
    script1, script2;

  script1 = document.createElement("script");
  script1.type = "text/x-mathjax-config";
  script1.innerHTML = "//<![CDATA[\n" +
    "MathJax.Hub.Config({\n" +
    "  'HTML-CSS': {  linebreaks: { automatic: true },\n" +
    "                 availableFonts: [], preferredFont: null, webFont: 'STIX-Web' },\n" +
    "         SVG: {  linebreaks: { automatic: true } }\n});\n" +
    "//]]>";

  script2 = document.createElement("script");
  window.onload = () => prettyPrint();

  head.appendChild(script1);
}());
