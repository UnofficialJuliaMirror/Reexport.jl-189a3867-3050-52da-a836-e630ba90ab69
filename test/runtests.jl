using Base.Test  

module X1
    using Reexport
    @reexport module Y1
        const Z1 = 1
        export Z1
    end
end

@test Set(names(X1)) == Set([:X1, :Y1, :Z1])
@test X1.Z1 == 1

module Y2
    const Z2 = 2
    export Z2
end
module X2
    using Reexport
    @reexport using Y2
end
@test Set(names(X2)) == Set([:X2, :Y2, :Z2])
@test X2.Z2 == 2

module X3
    using Reexport
    module Y3
        const Z3 = 3
        export Z3
    end
    module Y4
        const Z4 = 4
        export Z4
    end
    @reexport using .Y3, .Y4
end
@test Set(names(X3)) == Set([:X3, :Y3, :Y4, :Z3, :Z4])
@test X3.Z3 == 3
@test X3.Z4 == 4