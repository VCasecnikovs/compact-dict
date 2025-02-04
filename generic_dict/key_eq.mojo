from .keys_container import KeyRef

@always_inline
fn eq(a: KeyRef, b: KeyRef) -> Bool:
    let l = a.size
    if l != b.size:
        return False
    let p1 = a.pointer
    let p2 = b.pointer
    var offset = 0
    alias step = 16
    while l - offset >= step:
        let unequal = p1.simd_load[step](offset) != p2.simd_load[step](offset)
        if unequal.reduce_or():
            return False
        offset += step
    while l - offset > 0:
        if p1.load(offset) != p2.load(offset):
            return False
        offset += 1
    return True
