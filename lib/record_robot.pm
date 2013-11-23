package record_robot;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
  template 'index';
};


get '/init' => sub {
  system('stty -F /dev/ttyUSB0 115200 cs8 -crtscts -parenb -clocal -icanon -inlcr');
  return 'initialized';
};

post '/write' => sub {
  my $session_id = param "session_id";
  my $terminal = param "terminal";
  my $value = param "value";
  #echo "#3P900" >> /dev/ttyUSB0
  system("echo \"#${terminal}P${value}00\" >> /dev/ttyUSB0");
  system("echo \"#${terminal}P${value}00\" >> /tmp/log__$session_id");
  return "wrote ${value}00 to $terminal";
};
true;
