function randomize(df, tProp, vProp)
    Random.seed!(1);
    obs = nrow(df)
    trainRows = sample(1:obs, convert(Int, floor(obs*tProp)), replace=false)
    validRows = sample(setdiff(1:obs, trainRows), convert(Int, floor(obs*(1-tProp)*vProp)), replace=false)
    testRows = setdiff(1:obs, [trainRows; validRows])

    CSV.write("./trainTestData/train.csv", df[trainRows, :])
    CSV.write("./trainTestData/test.csv", df[testRows, :])
    CSV.write("./trainTestData/valid.csv", df[validRows, :])
end
