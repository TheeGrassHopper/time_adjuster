# frozen_string_literal: true

describe TimeAdjuster do

  let(:time) { '09:13 AM' }
  let(:adjusted_min) { 200 }

  let(:arguments) do
    {
      time: time,
      adjusted_min: adjusted_min
    }
  end
  subject { TimeAdjuster.new(**arguments).add_minutes }

  describe '#initialize' do
    context 'Argument Errors' do
      %i[time adjusted_min].each do |key|
          context "when missing required parameter: #{key}" do
            let(key) { nil }

            it 'raises an Argument Error' do
              expect { subject }.to raise_error(ArgumentError)
          end
        end
      end
    end

    context 'Invalid time argument' do
      let(:time) { '000:000 DD' }

      it 'raises error' do
        expect { subject }.to raise_error( ArgumentError, 'Invalid time: 000:000 DD')
      end
    end

    context 'Invalid adjusted min argument' do
      let(:adjusted_min) { 23.22 }

      it 'raises error' do
        expect { subject }.to raise_error( ArgumentError, 'Argument formate error')
      end
    end

    context 'adjusted_hours < 12 but 1 hours' do
      let(:time) { '10:13 AM' }
      let(:adjusted_min) { 200 }

      it 'subtract 12 hours from adjusted_hours set meridian to PM' do
        expect(subject).to eq('1:33 PM')
      end
    end

    context 'adjusted_hours < 12 but 1 hours' do
      let(:time) { '08:13 AM' }
      let(:adjusted_min) { 200 }

      it 'leave adjusted_hours hours and set meridian to AM' do
        expect(subject).to eq('11:33 AM')
      end
    end

    context 'adjusted_hours < 12 but 2 hours' do
      let(:time) { '07:13 AM' }
      let(:adjusted_min) { 200 }

      it 'leave adjusted_hours hours and set meridian to AM' do
        expect(subject).to eq('10:33 AM')
      end
    end

    context 'adjusted_hours < 12' do
      let(:time) { '09:13 PM' }
      let(:adjusted_min) { 300 }

      it 'leave adjusted_hours hours and set meridian to AMM' do
        expect(subject).to eq('2:13 AM')
      end
    end
  end
end

