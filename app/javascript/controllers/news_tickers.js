document.addEventListener("DOMContentLoaded", function() {
    const newsItems = document.querySelectorAll(".news-item");
    const ticker = document.getElementById("news-ticker");
    let currentIndex = 0;
  
    function showNextNews() {
      if (newsItems.length > 0) {
        newsItems[currentIndex].classList.remove("visible");
        currentIndex = (currentIndex + 1) % newsItems.length;
        newsItems[currentIndex].classList.add("visible");
      }
    }
  
    if (newsItems.length > 0) {
      newsItems[currentIndex].classList.add("visible");
      setInterval(showNextNews, 5000); // 5000 milliseconds = 5 seconds
    }
  });