<% content_for :javascripts do %>
<script>
$(document).ready(function () {
  if (!page_options.initialised){
    page_options.init(false, '', '');
  }
});
</script>
<% end %>
