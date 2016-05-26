// Generated by CoffeeScript 1.4.0
var TitleView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TitleView = (function(_super) {

  __extends(TitleView, _super);

  function TitleView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    TitleView.__super__.constructor.call(this, this.site_item);
    this.page_header = new_dom_element({
      parentNode: this.el,
      nodeName: "h1",
      className: "page-header",
      txt: this.site_item.title.get()
    });
  }

  return TitleView;

})(Process);