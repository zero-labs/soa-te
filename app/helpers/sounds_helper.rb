module SoundsHelper
  def day_playlist_tag
    content_tag("object", { :classid => 'clsid:d27cdb6e-ae6d-11cf-96b8-444553540000', 
                            :codebase => 'http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0',
                            :width => '400', :height => '168'}) do
        param_tag('allowScriptAccess', 'sameDomain')
        param_tag('movie', "#{flash_path('xspf_player')}")
        param_tag('quality', 'high')
        param_tag('bgcolor', '#E6E6E6')
        content_tag("embed", {:src => "#{flash_path('xspf_player')}&playlist_url=#{sounds_path}/day.xspf", 
                              :quality => 'high', :bgcolor => '#E6E6E6', :name => 'xspf_player',
                              :allowscriptaccess => 'sameDomain', :type => 'application/x-shockwave-flash',
                              :pluginspace => 'http://www.macromedia.com/go/getflashplayer',
                              :align => 'center', :height => '168', :width => '400'}) { }
    end
  end
  
  def button_player(file)
    "<object data=\\\"/flash/button/musicplayer.swf?song_url=#{file}\\\" height=\\\"17\\\" type=\\\"application/x-shockwave-flash\\\" width=\\\"17\\\">" + "<param name=\\\"movie\\\" value=\\\"/flash/button/musicplayer.swf?song_url=#{file}\\\" /></object>"
  end
end
