// Generated by CoffeeScript 1.4.0
var HeadingView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

HeadingView = (function(_super) {

  __extends(HeadingView, _super);

  function HeadingView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    HeadingView.__super__.constructor.call(this, this.site_item);
    if (this.site_item.num.get() === 1) {
      this.h1 = new_dom_element({
        nodeName: "h1",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 2) {
      this.h2 = new_dom_element({
        nodeName: "h2",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 3) {
      this.h3 = new_dom_element({
        nodeName: "h3",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 4) {
      this.h4 = new_dom_element({
        nodeName: "h4",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 5) {
      this.h5 = new_dom_element({
        nodeName: "h5",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 6) {
      this.h6 = new_dom_element({
        nodeName: "h6",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    }
  }

  return HeadingView;

})(Process);