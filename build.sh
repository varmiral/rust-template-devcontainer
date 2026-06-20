#!/usr/bin/env bash
set -e

release_build_std() {
    cargo +nightly build \
        -Z build-std=std,panic_abort \
        --profile release \
        "$@"
}

release_min_size() {
    cargo +nightly build \
        -Z panic-immediate-abort \
        -Z build-std \
        -Z build-std-features=optimize_for_size \
        --profile release \
        --config profile.release.opt-level=\"s\" \
        --config profile.release.lto=\"fat\" \
        --config profile.release.panic=\"immediate-abort\" \
        "$@"
}

"$@"
