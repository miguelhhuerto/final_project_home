$(document).ready(function() {
  $('.category-button').on('click', function() {
    var selectedCategoryIds = [];
    var categoryButton = $(this);
    
    if (categoryButton.data('category-id') === 'all') {
      $('.category-button').removeClass('active');
      categoryButton.addClass('active');
    } else {
      categoryButton.toggleClass('active');
      $('.category-button[data-category-id="all"]').removeClass('active');
      $('.category-button.active').each(function() {
        selectedCategoryIds.push($(this).data('category-id'));
      });
    }
    
    filterItems(selectedCategoryIds);
  });

  function filterItems(categoryIds) {
    $('.item-row').hide();
    if (categoryIds.length === 0 || categoryIds.includes('all')) {
      $('.item-row').show();
    } else {
      categoryIds.forEach(function(categoryId) {
        $('.item-row[data-category-ids*="' + categoryId + '"]').show();
      });
    }
  }
});