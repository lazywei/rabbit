set_foreground("black")
set_background("#f500f1d0c600")
#set_background_image("lavie.png")

include_theme("default")

include_theme("slide-number")

@title_logo_image = "lavie_with_logo.png"

include_theme("title-logo")

@headline_logo_image = "lavie.png"

include_theme("headline-logo")

@title_shadow_color = "#c09090"

include_theme("title-shadow")

@powered_by_image = "rabbit_banner.png"
@powered_by_text = "Rabbit and COZMIXNG"

include_theme("powered-by")

@icon_images = ["lavie_icon.png"]

include_theme("icon")

match(TitleSlide, Title) do |titles|
  titles.prop_set("foreground", "red")
  titles.prop_set("style", "italic")
end

slide_body = [Slide, Body]
item_list_item = [ItemList, ItemListItem]

# match(*slide_body) do |bodies|
#   bodies.vertical_centering = true
# end

match(*(slide_body + (item_list_item * 1))) do |items|
  items.clear_pre_draw_procs
  items.clear_post_draw_procs

  draw_image_mark(items, "red_item.png")
end

match(*(slide_body + (item_list_item * 2))) do |items|
  items.clear_pre_draw_procs
  items.clear_post_draw_procs

  draw_image_mark(items, "blue_item.png")
end

match(*(slide_body + (item_list_item * 3))) do |items|
  items.clear_pre_draw_procs
  items.clear_post_draw_procs

  draw_image_mark(items, "green_item.png")
end

enum_list_item = [EnumList, EnumListItem]

match(*(slide_body + enum_list_item + item_list_item)) do |items|
  items.clear_pre_draw_procs
  items.clear_post_draw_procs

  draw_image_mark(items, "red_item2.png")
end

match(*(slide_body + enum_list_item + (item_list_item * 2))) do |items|
  items.clear_pre_draw_procs
  items.clear_post_draw_procs

  draw_image_mark(items, "green_item.png")
end

if windows?
  match("**") do |elems|
    elems.prop_delete("style")
  end
end
