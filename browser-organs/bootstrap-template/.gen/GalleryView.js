// Generated by CoffeeScript 1.4.0
var GalleryView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

GalleryView = (function(_super) {

  __extends(GalleryView, _super);

  function GalleryView(site_item, el) {
    var i, _i, _ref;
    this.site_item = site_item;
    this.el = el;
    GalleryView.__super__.constructor.call(this, this.site_item);
    this.row = new_dom_element({
      className: "row",
      parentNode: this.el
    });
    this.width = "col-sm-6 col-md-" + this.site_item.col.get() + " col-lg-6";
    for (i = _i = 0, _ref = this.site_item.lst.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      this.col = new_dom_element({
        parentNode: this.row,
        className: this.width
      });
      if (this.site_item.lst_href[i]) {
        this.a = new_dom_element({
          nodeName: "a",
          parentNode: this.col,
          href: this.site_item.lst_href[i],
          target: "_blank"
        });
      } else {
        this.a = new_dom_element({
          nodeName: "a",
          parentNode: this.col
        });
      }
      this.image = new_dom_element({
        className: "image-info text-center",
        parentNode: this.a
      });
      this.image_inner = new_dom_element({
        className: "image-inner text-center",
        parentNode: this.image
      });
      this.i = new_dom_element({
        nodeName: "img",
        parentNode: this.image_inner,
        src: this.site_item.lst[i],
        style: {
          height: this.site_item.height.get()
        }
      });
      if (this.site_item.lst_captions[i] != null) {
        this.t = new_dom_element({
          nodeName: "h5",
          className: "text-center",
          parentNode: this.image,
          txt: this.site_item.lst_captions[i]
        });
      }
    }
  }

  return GalleryView;

})(Process);
