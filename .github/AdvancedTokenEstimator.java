package com.dailycodebuffer.ics;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class AdvancedTokenEstimator {

    public static void main(String[] args) throws Exception {
        Path skillsRoot = Paths.get(".github/skills");
        List<Path> skillFiles = findSkillFiles(skillsRoot);

        if (skillFiles.isEmpty()) {
            throw new IOException("No SKILL.md files found under " + skillsRoot.toAbsolutePath());
        }

        for (Path skillFile : skillFiles) {
            String content = Files.readString(skillFile);
            int tokens = estimateTokens(content);
            String name = skillName(content).orElse(skillFile.getParent().getFileName().toString());
            System.out.println(name + ": " + tokens);
        }
    }

    private static List<Path> findSkillFiles(Path skillsRoot) throws IOException {
        if (!Files.isDirectory(skillsRoot)) {
            return List.of();
        }

        try (Stream<Path> paths = Files.walk(skillsRoot)) {
            return paths
                    .filter(path -> Files.isRegularFile(path) && path.getFileName().toString().equals("SKILL.md"))
                    .sorted(Comparator.naturalOrder())
                    .toList();
        }
    }

    private static Optional<String> skillName(String content) {
        String[] lines = content.split("\\R");
        boolean inFrontMatter = false;

        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.equals("---")) {
                if (inFrontMatter) {
                    break;
                }
                inFrontMatter = true;
                continue;
            }

            if (!inFrontMatter) {
                continue;
            }

            if (trimmed.startsWith("name:")) {
                String value = trimmed.substring("name:".length()).trim();
                if (!value.isEmpty()) {
                    return Optional.of(value);
                }
            }
        }

        return Optional.empty();
    }

    public static int estimateTokens(String text) {

        // Split words + punctuation
        String[] tokens = Pattern.compile("\\w+|[^\\s\\w]").matcher(text)
                .results()
                .map(match -> match.group())
                .toArray(String[]::new);

        return tokens.length;
    }
}
