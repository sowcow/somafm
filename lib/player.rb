class Player
  def self.play channel
    url = channel.pls

    stop

    @pid = Process.spawn \
      "mplayer #{url} -allow-dangerous-playlist-parsing"
  end

  def self.stop
    Process.kill 'TERM', @pid if @pid
  end
end


__END__

    Process.kill "TERM", pid
    # this code is run in the child process
  #   # you can do anything here, like changing current directory or reopening STDOUT
  #     exec "/path/to/executable"
  #     end
  #
  #     # this code is run in the parent process
  #     # do your stuffs
  #
  #     # kill it (other signals than TERM may be used, depending on the program you want
  #     # to kill. The signal KILL will always work but the process won't be allowed
  #     # to cleanup anything)
  #     Process.kill "TERM", pid
  end
end
