require 'digester/digester'

describe Digester::Digester do
  klass = Digester::Digester

  [
      {},
      {
          namespace: 'md5',
      },
      {
          namespace: 'CPO',
          separator: '.',
          sort: true,
          uniquify: true,
          upcase: false
      },
  ].each_with_index do |options, i|

    context "run No.#{i+1} with options #{options}" do

      [
          [
              %w(first second third),
              'first::second::third',
              [true, true, false]
          ],
          [
              [1, 2, "2", {}, {x: 5}, [1, 2, 3]],
              '1.2.3.{:x=>5}.{}',
              [false, false, true]
          ]
      ].each do |(input, processed, equals)|
        context "with input #{input}" do
          before(:each) do
            digest = ::Digest::MD5.hexdigest(processed)
            if options[:namespace]
              @output_guess = "#{options[:namespace]}:#{digest}"
            else
              @output_guess = digest
            end
            @output_guess.upcase! if options[:upcase]
          end

          subject { klass.digest(input, options) }

          it { should be_a String }

          describe "should #{equals[i] ? "" : "not "}match the guessed digest for #{processed}" do
            specify { equals[i] ?
                subject.should == @output_guess :
                subject.should_not == @output_guess }
          end

        end
      end
    end
  end
end
