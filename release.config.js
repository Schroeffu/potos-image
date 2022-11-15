module.exports = {
    branches: "['+([0-9])?(.{+([0-9]),x}).x', 'master', 'develop', 'next', 'next-major', {name: 'beta', prerelease: true}, {name: 'alpha', prerelease: true}]",
    repositoryUrl: "https://github.com/Schroeffu/potos-image/",
    plugins: [
        "@semantic-release/commit-analyzer", 
        "@semantic-release/release-notes-generator", 
        "@semantic-release/github"
    ]
}
