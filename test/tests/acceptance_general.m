classdef acceptance_general < matlab.unittest.TestCase
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
        function ascii_set_creation(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/', true);
            ascii_set = drop_set(drops);
            ascii_set.set_settings(testCase.settings);
            testCase.assertInstanceOf(ascii_set, 'drop_set');
            testCase.assertNotEmpty(ascii_set.drops);
            testCase.assertEqual(ascii_set.num_drops, length(ascii_set.drops));
        end

       %     function mat_set_creation(testCase)
       %         drops = testCase.assembler.assemble('resources/small_data/mat/test.mat', 0, false);
       %         mat_set = drop_set(drops);
       %         testCase.assertInstanceOf(mat_set, 'drop_set');
       %         testCase.assertNotEmpty(mat_set.drops);
       %         testCase.assertEqual(mat_set.num_drops, length(mat_set.drops));
       %     end

        function drop_assembler_generates_non_empty_list_of_ascii_drops(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/', true);
            testCase.assertNotEmpty(drops);
            for i=1:length(drops)
                testCase.assertInstanceOf(drops(i).Value, 'drop');
            end
        end

       %     function drop_assembler_generates_non_empty_list_of_mat_drops(testCase)
       %         drops = testCase.assembler.assemble('resources/small_data/mat/test.mat', 0, false);
       %         testCase.assertNotEmpty(drops);
       %         for i=1:length(drops)
       %             testCase.assertInstanceOf(drops(i).Value, 'drop');
       %         end
       %     end

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
            drops = testCase.assembler.assemble('resources/small_data/ascii/', true);
            set = drop_set(drops);
            set.set_settings(testCase.settings);
            preproc = preprocessor();
            preproc.preprocess_signals(set, 0, max(set.drops(1).Value.signals('time').data));
        end 

        function velocity_process_basic_code_correctness(testCase)
            addpath('../../lib/framework/subprocesses/');
            drops = testCase.assembler.assemble('resources/small_data/ascii/', true);
            set = drop_set(drops);
            set.set_settings(testCase.settings);
            preproc = preprocessor();
            preproc.preprocess_signals(set, 0, max(set.drops(1).Value.signals('time').data));
            proc = processor();
            collector = calculation_collector();
            process = process_velocity_validation(set);
            proc.apply_process(collector, set, process);
        end
    end
end
