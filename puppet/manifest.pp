include 'docker'

class {'docker':
  tcp_bind     => 'tcp://127.0.0.1:4243',
  socket_bind  => 'unix:///var/run/docker.sock',
  version      => '0.5.5',
  dns          => '8.8.8.8',
  docker_users => [ 'user1', 'user2' ],
}
