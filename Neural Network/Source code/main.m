function [] = main(training_file, test_file, layers, units_per_layer, rounds)
    obj = neural_network(training_file, test_file, layers, units_per_layer, rounds);
    obj = obj.initialise(obj);
    for i = 1:obj.rounds
        obj = obj.feed_forward(obj, i-1);
    end
    obj = obj.testing(obj);
end