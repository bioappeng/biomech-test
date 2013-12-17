classdef integration_general < matlab.unittest.TestCase
    properties
        assembler;
        settings;
    end
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../lib/framework/');
            addpath('resources/');
            addpath('../../lib/resources/');
            addpath('../../lib/resources/yamlmatlab/');
            file = fopen('resources/calculated', 'w+');
            fprintf(file, '');
            fclose(file);
        end

        function class_setup_objects(testCase)
            parser = settings_parser('resources/settings.yaml');
            testCase.settings = parser.parse_settings();
            testCase.assembler = drop_assembler(testCase.settings);
        end
    end

    methods(TestMethodSetup)
        function setup_Sets(testCase)
        end
    end

    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end

    methods(Test)
        function test_ascii_set_created_correctly_and_settings_correctly_applied(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/');
            ascii_set = drop_set(drops);
            ascii_set.set_settings(testCase.settings);
            preproc = preprocessor();
            preproc.preprocess_signals(ascii_set);
            testCase.assertEqual(ascii_set.get_drop(1).signals('pot').data(758), 1.056)
        end

        function drop_assembler_generates_non_empty_list_of_ascii_drops(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/');
            testCase.assertNotEmpty(drops);
            for i=1:length(drops)
                testCase.assertInstanceOf(drops(i).Value, 'drop');
            end
        end

        function dumper_dumps_data_to_file(testCase)
            non_empty_collector = calculation_collector();
            non_empty_collector.add_field([1;2;3;4;5;6], 'a_field_name');
            dumper = data_dumper();
            dumper.grab_data(non_empty_collector);
            dumper.dump('resources/calculated');
            fileid = fopen('resources/calculated');
            file = fread(fileid);
            fclose(fileid);
            testCase.assertNotEmpty(file);
        end

        function preprocess_basic_code_correctness(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/');
            set = drop_set(drops);
            set.set_settings(testCase.settings);
            preproc = preprocessor();
            preproc.preprocess_signals(set);
        end 

        function velocity_process_basic_code_correctness(testCase)
            addpath('../../lib/framework/subprocesses/');
            drops = testCase.assembler.assemble('resources/small_data/ascii/');
            set = drop_set(drops);
            set.set_settings(testCase.settings);
            preproc = preprocessor();
            preproc.preprocess_signals(set);
            proc = processor();
            collector = calculation_collector();
            process = process_velocity_validation(set);
            proc.apply_process(collector, set, process);
        end
    end
end
