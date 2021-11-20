
use_osc "127.0.0.1", 12000

live_loop :send_osc do
  play [:c3, :f3, :a3, :e4, :g4].choose + [0,12].choose, amp: 0.8, release: 4.0
  osc "/rgb_circle"
  sleep 1
end
