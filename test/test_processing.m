classdef test_processing < matlab.unittest.TestCase
    properties
        proc
        collector
        Set
    end

    methods(TestClassSetup)
        function class_setup(testCase)
            file = fopen('resources/calculated', 'w+');
            fprintf(file, '');
            fclose(file);
            addpath('resources');
            addpath('../lib/resources/');
            addpath('../lib/framework/');
            addpath('../lib/framework/subprocesses');
        end
    end

    methods(TestMethodSetup)
        function setup(testCase)
            testCase.collector = calculation_collector();
            testCase.proc = processor();
        end

        function setupMocks(testCase)
            testCase.Set.num_drops = 3;
        end
    end

    methods(TestMethodTeardown)
        function teardown(testCase)
            clear testCase.Set;
        end
    end

    methods(Test)
        function test_apply_process(testCase)
            a_basic_process = process_basic_process();
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, a_basic_process);
            testCase.assertEqual(a_basic_process.value,...
                                 testCase.collector.calculated.test);
        end

        function test_process_max_accx(testCase)
            drop1.Value.accx = signal('', [1,2,3,4]);
            drop2.Value.accx = signal('', [1,2,500,-501]);
            drop3.Value.accx = signal('', [-100,2,3]);
            testCase.Set.drops = [drop1, drop2, drop3];
            process = process_max_accx();
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, process);
            testCase.assertEqual(testCase.collector.calculated.max_accx, [4;501;100]);
        end

        function test_process_max_accy(testCase)
            drop1.Value.accy = signal('', [1,2,3,4]);
            drop2.Value.accy = signal('', [1,2,500,-501]);
            drop3.Value.accy = signal('', [-100,2,3]);
            process = process_max_accy();
            testCase.Set.drops = [drop1, drop2, drop3];
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, process);
            testCase.assertEqual(testCase.collector.calculated.max_accy, [4;501;100]);
        end

        function test_process_max_accz(testCase)
            drop1.Value.accz = signal('', [1,2,3,4]);
            drop2.Value.accz = signal('', [1,2,500,-501]);
            drop3.Value.accz = signal('', [-100,2,3]);
            testCase.Set.drops = [drop1, drop2, drop3];
            process = process_max_accz();
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, process);
            testCase.assertEqual(testCase.collector.calculated.max_accz, [4;501;100]);
        end

        function test_add_field_for_num(testCase)
            field_name = 'test';
            value = 7.21234;
            testCase.collector.add_field(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end
        
        function test_add_field_for_matrix(testCase)
            field_name = 'test';
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            testCase.collector.add_field(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end

        function test_access_field_if_exists(testCase)
            data = [1,2,3,4,5,6,1];
            testCase.collector.add_field(data, 'testdata');
            testCase.assertEqual(testCase.collector.access_field('testdata'), data);
        end

        function test_access_field_if_not_exist(testCase)
            testCase.assertEqual(testCase.collector.access_field('notvaliddata'), []);
        end

        function test_dumper_copies_data_from_calculation_collector(testCase)
            non_empty_collector = calculation_collector();
            non_empty_collector.add_field([1;2;3;4;5;6], 'a_field_name');
            dumper = data_dumper();
            dumper.grab_data(testCase.collector);
            testCase.assertEqual(dumper.data, testCase.collector.calculated);
        end

        function test_dumper_dumps_data_to_file_using(testCase)
            non_empty_collector = calculation_collector();
            non_empty_collector.add_field([1;2;3;4;5;6], 'a_field_name');
            dumper = data_dumper();
            dumper.grab_data(non_empty_collector);
            dumper.dump('resources/calculated')
            fileid = fopen('resources/calculated');
            file = fread(fileid);
            fclose(fileid);
            testCase.assertNotEmpty(file);
        end
    end
end
