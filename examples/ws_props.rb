require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

props = \
[
        'name',
        'parent',
        'rows',
        'cols',
        'merged_ranges',
        'bmp_rec',
        'show_formulas',
        'show_grid',
        'show_headers',
        'panes_frozen',
        'show_empty_as_zero',
        'auto_colour_grid',
        'cols_right_to_left',
        'show_outline',
        'remove_splits',
        'selected',
        'page_preview',
        'first_visible_row',
        'first_visible_col',
        'grid_colour',
        'preview_magn',
        'normal_magn',
        'show_auto_page_breaks',
        'dialogue_sheet',
        'auto_style_outline',
        'outline_below',
        'outline_right',
        'fit_num_pages',
        'show_row_outline',
        'show_col_outline',
        'alt_expr_eval',
        'alt_formula_entries',
        'row_default_height',
        'col_default_width',
        'calc_mode',
        'calc_count',
        'save_recalc',
        'print_headers',
        'print_grid',
        'grid_set',
        'vert_page_breaks',
        'horz_page_breaks',
        'header_str',
        'footer_str',
        'print_centered_vert',
        'print_centered_horz',
        'left_margin',
        'right_margin',
        'top_margin',
        'bottom_margin',
        'paper_size_code',
        'print_scaling',
        'start_page_number',
        'fit_width_to_pages',
        'fit_height_to_pages',
        'print_in_rows',
        'portrait',
        'print_not_colour',
        'print_draft',
        'print_notes',
        'print_notes_at_end',
        'print_omit_errors',
        'print_hres',
        'print_vres',
        'header_margin',
        'footer_margin',
        'copies_num',
]

props.each_with_index do |p, i|
  value = sheet.send(p.to_sym)
  puts "#{p} #{value}"
  sheet.write(i+2, 0, p)
  sheet.write(i+2, 1, value)
end

book.save(__FILE__.gsub(/rb$/, "xls"))

