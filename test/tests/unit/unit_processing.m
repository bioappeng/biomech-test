classdef unit_processing < matlab.unittest.TestCase
    properties
        proc
        collector
        Set
    end

    methods(TestClassSetup)
        function class_setup(testCase)
            addpath('../resources/');
            addpath('../../../lib/resources/');
            addpath('../../../lib/framework/');
            addpath('../../../lib/framework/subprocesses');
            testCase.proc = processor();
        end
    end

    methods(TestMethodSetup)
        function setup(testCase)
            testCase.collector = calculation_collector();
        end

        function setupMocks(testCase)
        end
    end

    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end

    methods(Test)
       % function test_apply_process(testCase)
       %     a_basic_process = process_basic_process();
       %     testCase.proc.apply_process(testCase.collector,...
       %                                 testCase.Set, a_basic_process);
       %     testCase.assertEqual(a_basic_process.value,...
       %                          testCase.collector.calculated.test);
       % end
        
%        function test_process_max_accx(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('accx') = signal('accx', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('accx') = signal('accx', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('accx') = signal('accx', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_accx();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_accx, [4;501;100]);
%        end
%
%        function test_process_max_accy(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('accy') = signal('accy', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('accy') = signal('accy', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('accy') = signal('accy', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_accy();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_accy, [4;501;100]);
%        end
%
%        function test_process_max_accz(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('accz') = signal('accz', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('accz') = signal('accz', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('accz') = signal('accz', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_accz();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_accz, [4;501;100]);
%        end
%
%         function test_process_max_loadx(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('loadx') = signal('loadx', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('loadx') = signal('loadx', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('loadx') = signal('loadx', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_loadx();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_loadx, [4;501;100]);
%        end
%
%         function test_process_max_load(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('load') = signal('load', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('load') = signal('load', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('load') = signal('load', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_load();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_load, [4;501;100]);
%        end
%
%         function test_process_max_loady(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('loady') = signal('loady', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('loady') = signal('loady', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('loady') = signal('loady', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_loady();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_loady, [4;501;100]);
%        end
%
%         function test_process_max_loadz(testCase)
%            import containers.Map;
%
%            signals1 = Map();
%            signals2 = Map();
%            signals3 = Map();
%            signals1('loadz') = signal('loadz', [1,2,3,4]);
%            drop1 = drop(signals1, 'one');
%            signals2('loadz') = signal('loadz', [1,2,500,-501]);
%            drop2 = drop(signals2, 'two');
%            signals3('loadz') = signal('loadz', [-100,2,3]);
%            drop3 = drop(signals3, 'three');
%            collector = calculation_collector();
%            drops = [];
%            drops(1).Value = drop1;
%            drops(2).Value = drop2;
%            drops(3).Value = drop3;
%            set = drop_set(drops);
%            process = process_max_loadz();
%            proc = processor();
%            proc.apply_process(collector, set, process);
%            testCase.assertEqual(collector.calculated.max_loadz, [4;501;100]);
%        end
   end
end
