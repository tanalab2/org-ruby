require 'spec_helper'
require 'pathname'

describe Tilt::OrgTemplate do
  describe "Set default options test cases" do
    def get_file_pair_from_html_examples(basename)
      data_directory = File.join(File.dirname(__FILE__), "html_examples")
      file = File.expand_path(File.join(data_directory, basename + ".org"))
      textile_name = File.join(data_directory, basename + ".html")
      textile_name = File.expand_path(textile_name)
      return file, textile_name
    end

    context "without in-buffer option in file" do
      it "should be set empty options when no default options is specified" do
        file, textile_name = get_file_pair_from_html_examples("text")
        expected = IO.read(textile_name)
        tilt = Tilt.new(file)
        expect(tilt.options).to eq({})
        expect(tilt.instance_variable_get("@engine").options).to eq({})
        template = tilt.render
        expect(template).to eq(expected)
      end

      it "should be set default options when default options is specified" do
        file, textile_name = get_file_pair_from_html_examples("text")
        expected = IO.read(textile_name)
        default_options = {"f" => "t"}
        tilt = Tilt.new(file, default_options)
        expect(tilt.options).to eq(default_options)
        expect(tilt.instance_variable_get("@engine").options).to eq(default_options)
        template = tilt.render
        expect(tilt.instance_variable_get("@engine").options).to eq(default_options)
        expect(template).to eq(expected)
      end

      it "should render with default options" do
        file_with_options, output_with_options = get_file_pair_from_html_examples("footnotes")
        file_without_options, _ = get_file_pair_from_html_examples("footnotes_without_option")

        expect(IO.read(file_with_options)).to include("#+OPTIONS: f:t")
        expect(IO.read(file_without_options)).not_to include("#+OPTIONS: f:t")

        expected = IO.read(output_with_options)

        tilt = Tilt.new(file_without_options)
        expect(tilt.options).to eq({})
        expect(tilt.instance_variable_get("@engine").options).to eq({})
        template = tilt.render
        expect(template).not_to eq(expected)

        default_options = {"f" => "t"}
        tilt = Tilt.new(file_without_options, default_options)
        expect(tilt.options).to eq(default_options)
        expect(tilt.instance_variable_get("@engine").options).to eq(default_options)
        template = tilt.render
        expect(template).to eq(expected)
      end
    end

    context "with in-buffer option in file" do
      it "should render with in-buffer options rather than default options" do
        file, textile_name = get_file_pair_from_html_examples("footnotes")

        expect(IO.read(file)).to include("#+OPTIONS: f:t")
        in_buffer_options = {"f" => "t"}

        expected = IO.read(textile_name)
        tilt = Tilt.new(file)
        expect(tilt.options).to eq({})
        template = tilt.render
        expect(tilt.instance_variable_get("@engine").options).to eq(in_buffer_options)
        expect(template).to eq(expected)

        default_options = {"f" => "f"}
        tilt = Tilt.new(file, default_options)
        expect(tilt.options).to eq(default_options)
        expect(tilt.instance_variable_get("@engine").options).to eq(in_buffer_options)
        template = tilt.render
        expect(template).to eq(expected)
      end
    end
  end
end
