
use_osc "127.0.0.1", 54110

live_loop :metro do
  sleep 1
end


live_loop :send_osc do
  use_synth :hollow
  play [:c3, :f3, :a3, :e4, :g4].choose + [0,12].choose, amp: 0.8, release: 4.0
  osc "/rgb_circle", rrand(0,255), rrand(0,255), rrand(0, 255)
  osc "/pos_circle", 1000.0, 100.0
  sleep 0.25
end


with_fx :echo, mix: 0.3 do
  live_loop :haunted do
    sample :perc_bell, rate: rrand(-1.5, 1.5), amp: 0.3
    sleep rrand(0.1, 2)
  end
end

with_fx :lpf, cutoff: 90 do
  with_fx :reverb, mix: 0.5 do
    with_fx :compressor, pre_amp: 40 do
      with_fx :distortion, distort: 0.4 do
        live_loop :jungle do
          use_random_seed 667
          4.times do
            sample :loop_amen, beat_stretch: 4, rate: [1, 1, 1, -1].choose / 2.0, finish: 0.5, amp: 0.01
            sample :loop_amen, beat_stretch: 4, amp: 0.01
            sleep 4
          end
        end
      end
    end
  end
end



load_samples(sample_names :ambi)
sleep 2

live_loop :foo do
  #sp_name = choose sample_names :ambi
  sp_name = choose sample_names :drum
  sp_time = [0.5, 0.25,0.125, 0.125].choose
  sp_rate = 1
  s = sample sp_name, cutoff: rrand(70, 130), rate: sp_rate * choose([0.5, 1]), pan: rrand(-1, 1), pan_slide: sp_time
  control s, pan: rrand(-1, 1)
  sleep sp_time
end








