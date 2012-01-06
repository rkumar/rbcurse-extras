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

    Type Alt-: to see customization menu. You may select:

    * edit_toggle: when false you are always in insert mode.
                   when true, you are in command mode, but can go into
                   edit/insert mode by pressing <edit_toggle_key> currently
                   C-e. You can also complete edit using <ESC>. 
                   You may cancel edit using C-c or C-g.

    * one_key_selection : if you are not in insert mode you can switch this on, so pressing
                  any alphabet takes you to first row starting with that char.
                  If false, then you are in so-called "vim" mode, so u can use j/k/gg/G etc keys.
                  To get the same functionality of one-key, use f<char>.

    Navigation: use arrow keys, or C-n, C-p, C-d, C-f. In command mode, pressing '?' displays
                  key-bindings.



    =========================================================================
    :n or Alt-n for next buffer. 'q' to quit.

    eos
  end



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
  header = app_header "rbcurse #{Rbcurse::VERSION}", :text_center => "Listbox Demo", :text_right =>"New Improved!", :color => :white, :bgcolor => back #, :attr => :bold 
  message "F10 - Exit, F1 - Help, : - Menu"
  install_help_text my_help_text

  alist = File.open("data/list.txt",'r').readlines.map{|i| i.chomp }
  #atable = File.open("data/table.txt",'r').readlines

  #stack :margin_top => 1, :width => :expand, :height => FFI::NCurses.LINES-2 do
  max = FFI::NCurses.LINES-2
  maxw = FFI::NCurses.COLS-1
    lb = Listbox.new @form, :list => alist, :suppress_borders => false, :title => "[ brew packages ]",
      :left_margin => 1, :width => maxw, :name => 'lb1', :height => max, :row => 1, :col => 1, :cell_editing_allowed => true
    lb.show_selector = false
    #require 'rbcurse/core/include/widgetmenu'
    #lb.extend(WidgetMenu)
    #lb.add_menu_item('z', 'test from app', 'some desc', Proc.new { alert "Hello world" } )
    lb.action_manager().add_action( Action.new("&Testing from app"){ alert "testing from app" } )
    
  #end
  sl = status_line :row => FFI::NCurses.LINES-1
  #
  # does a resize when form resized
  def resize
    # NOTE listbox celleditor's size needs to be changed too.
    lb = @form.by_name["lb1"]
    lb.width = Ncurses.COLS-1
    max = FFI::NCurses.LINES-2
    lb.height = max
    lb.repaint
    #sl.row( max + 1)
    sl = @form.by_name["sl"]
    max = FFI::NCurses.LINES-1
    sl.row = max
    h = @form.by_name["header"]
    h.repaint_all(true)
    @window.wrefresh
  end
  @form.bind(:RESIZE) { resize() }
  #label({:text => "F1 Help, F10 Quit. : for menu. Press F4 and F5 to test popup, space or enter to select", :row => Ncurses.LINES-1, :col => 0})


end # app
