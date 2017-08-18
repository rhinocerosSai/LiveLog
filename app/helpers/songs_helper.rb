module SongsHelper
  INST_ORDER = %w[Vo Vn Vla Vc Fl Cl Sax Tp Hr Tb Harp Gt Koto Pf Acc 鍵ハ Ba Cj Dr Bongo Perc].freeze

  def sort_by_inst(playings)
    playings.sort do |p1, p2|
      inst_order(p1.inst) <=> inst_order(p2.inst)
    end
  end

  def can_watch?(song)
    !song.youtube_id.blank? && (song.open? || song.closed? && logged_in? || logged_in? && current_user.played?(song))
  end

  def can_edit?(song)
    logged_in? && (current_user.admin_or_elder? || current_user.played?(song))
  end

  def button_to_add_member(text, f)
    fields = f.fields_for(:playings, @song.playings.build) do |builder|
      render 'songs/playings_fields', f: builder
    end
    content_tag :button, text, id: 'add-member', type: 'button', class: 'btn btn-link', data: { fields: fields.gsub("\n", '') }
  end

  private

  def inst_order(inst)
    priority = INST_ORDER.index { |i| inst.include?(i) }
    priority ? priority : INST_ORDER.size
  end
end
