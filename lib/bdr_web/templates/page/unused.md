<div class="tile is-ancestor">
    <div class="tile is-parent">
    <%= Enum.map(@homepage_collections, fn(collection) -> %>
        <div class="tile is-child is-3">
            <img class="search__image" src="/images/phoenix.png"> 
            <h4 class="search__title">
                <%= collection.name %>
            </h4>
            
            <div class="search__details">
                <h5>
                Times drawn <%= collection.name %>
                </h5>
            </div>
        </div>
        <% end) %>
    </div>          
</div>        