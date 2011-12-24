require 'rbcurse/core/util/app'
require 'rbcurse/core/include/appmethods'
require 'rbcurse/extras/widgets/rlistbox'

  def my_help_text
    <<-eos
    File : testeditlist.rb

    =========================================================================
    Basic Usage

    This simple example shows the old editable list. This was the original
    list, but pretty complicated due to editing. You can switch off the editing.

    While editing, you can cancel using ESC or C-c.

    Navigation: use arrow keys, or C-n, C-p, C-d, C-f



    =========================================================================
    :n or Alt-n for next buffer. 'q' to quit.

    eos
  end



# just a simple test to ensure that rbasiclistbox is running inside a container.
App.new do 
  #
  # general purpose command to catch miscellaneous actions that can be 
  # executed in the same way. Or even take complex command lines
  # such as what vim has.
  def execute_this *cmd
    f = @form.get_current_field
    w = f
    name = w.text.split()[0]
    cmd = cmd[0].to_s
  end

  colors = Ncurses.COLORS
  back = :blue
  back = 234 if colors >= 256
  header = app_header "rbcurse #{Rbcurse::VERSION}", :text_center => "Rbcurse Demo", :text_right =>"New Improved!", :color => :white, :bgcolor => back #, :attr => :bold 
  message "F10 - Exit, F1 - Help, : - Menu"
  install_help_text my_help_text

  alist = File.open("data/list.txt",'r').readlines.map{|i| i.chomp }
  atable = File.open("data/table.txt",'r').readlines

  #stack :margin_top => 1, :width => :expand, :height => FFI::NCurses.LINES-2 do
  max = FFI::NCurses.LINES-2
    lb = Listbox.new @form, :list => alist, :suppress_borders => false, :title => "[ brew packages ]",
      :left_margin => 1, :width => 100, :name => 'lb1', :height => max, :row => 1, :col => 1, :cell_editing_allowed => true
    lb.show_selector = false
    require 'rbcurse/core/include/widgetmenu'
    lb.extend(WidgetMenu)
    lb.add_menu_item('z', 'test from app', 'some desc', Proc.new { alert "Hello world" } )
    
  #end
  status_line :row => FFI::NCurses.LINES-1
  #label({:text => "F1 Help, F10 Quit. : for menu. Press F4 and F5 to test popup, space or enter to select", :row => Ncurses.LINES-1, :col => 0})



  @form.bind_key(?:) { disp_menu; }
  #@form.bind_key(?\M-:) { disp_menu; }
end # app
