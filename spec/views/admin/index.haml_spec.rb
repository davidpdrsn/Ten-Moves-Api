require 'rails_helper'

describe 'admin/index.haml' do
  it 'shows when there are no moves' do
    assign :dashboard, build_dashboard(9, [])
    render
    expect(rendered).to match /9/
  end

  it 'shows when there are no moves' do
    assign :dashboard, build_dashboard(1, ["foo"])
    render
    expect(rendered).to match "foo"
  end

  it 'shows the top list of moves' do
    assign :dashboard, build_dashboard(0, [])
    render
    expect(rendered).to match /There are no moves/
  end

  def build_dashboard(total_moves_count, top_list)
    double(
      'dashboard',
      total_moves_count: total_moves_count,
      top_list: top_list,
      empty?: total_moves_count == 0,
    )
  end
end
