// Generated by CoffeeScript 1.4.0
var TreeView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TreeView = (function(_super) {

  __extends(TreeView, _super);

  function TreeView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    TreeView.__super__.constructor.call(this, this.site_item);
    this.jstree = new_dom_element({
      id: this.site_item.id.get(),
      className: "jstree jstree-1 jstree-default",
      parentNode: this.el
    });
    this.render(this.site_item, this.jstree);
  }

  TreeView.prototype.render = function(item, el) {
    var child, i, li, _i, _j, _len, _ref, _ref1, _results;
    if (item._children.length > 0) {
      this.ul = new_dom_element({
        nodeName: "ul",
        parentNode: el
      });
      li = [];
      _ref = item._children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        if (child.type.get() === "file") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{ "icon" : "fa fa-file fa-lg text-primary" }',
            txt: child.txt.get()
          }));
        } else if (child.type.get() === "symlink") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{ "icon" : "fa fa-link fa-lg text-primary" }',
            txt: child.txt.get()
          }));
        } else if (child.type.get() === "opened") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{"opened":true, "icon" : "fa fa-folder fa-lg text-warning" }',
            txt: child.txt.get()
          }));
        } else {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{"opened":false, "icon" : "fa fa-folder fa-lg text-warning" }',
            txt: child.txt.get()
          }));
        }
      }
      _results = [];
      for (i = _j = 0, _ref1 = item._children.length - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
        _results.push(this.render(item._children[i], li[i]));
      }
      return _results;
    }
  };

  return TreeView;

})(Process);
