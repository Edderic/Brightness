              var g = new Bluff.Line('graph', "1000x600");
      g.theme_37signals();
      g.tooltips = true;
      g.title_font_size = "24px"
      g.legend_font_size = "12px"
      g.marker_font_size = "10px"

        g.title = 'Stats: LOC & LOT';
        g.data('LOC', [8,40]);
g.data('LOT', [24,23]);
        g.labels = {"0":"1/4","1":"1/5"};
        g.draw();
