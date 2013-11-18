$h1 = document.getElementsByTagName("H1")[0]
setTimeout ->
  $h1.innerText += " BOO!"
, 3000